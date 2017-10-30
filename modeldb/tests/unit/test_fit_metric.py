import unittest

from ...basic.ModelDbSyncerBase import *
from .ModelDbSyncerBaseTest import SyncerTest
from . import utils


class TestMetricEvent(unittest.TestCase):

    @classmethod
    def setUp(self):
        name = "event-test"
        author = "engapa"
        description = "testing events"
        syncer_obj = SyncerTest(
            NewOrExistingProject(name, author, description),
            DefaultExperiment(),
            NewExperimentRun("Abc"))

        syncer_obj.clear_buffer()

        datasets = {
            "train": Dataset("/path/to/train", {"num_cols": 15, "dist": "random"}),
            "test": Dataset("/path/to/test", {"num_cols": 15, "dist": "gaussian"})
        }

        # create the Model, ModelConfig, and ModelMetrics instances
        model = "myModel"
        model_type = "modelType"
        mdb_model = Model(model_type, model, "/path/to/model")
        mdb_config = ModelConfig(model_type, {"l1": 10})
        mdb_metrics = ModelMetrics({"confusion_matrix": [[141, 21], [41, 51]], "f1": 0.87})

        syncer_obj.sync_datasets(datasets)
        syncer_obj.sync_model('train', mdb_config, mdb_model)
        syncer_obj.sync_metrics('test', mdb_model, mdb_metrics)

        self.events = syncer_obj.sync()

    def test_events_and_types(self):
        # There should be 3 events, 1 fit event and 2 metric event
        self.assertEqual(len(self.events), 3)

        utils.validate_fit_event_struct(self.events[0], self)
        utils.validate_metric_event_struct(self.events[1], self)
        utils.validate_metric_event_struct(self.events[2], self)

    def test_fit_events(self):
        fit_event = self.events[0]

        self.assertEqual(fit_event.df.tag, 'train')
        self.assertEqual(fit_event.df.filepath, '/path/to/train')
        self.assertTrue([metadata.key for metadata in fit_event.df.metadata].sort() == ['num_cols', '15'].sort())
        self.assertTrue([metadata.key for metadata in fit_event.df.metadata].sort() == ['dist', 'random'].sort())
        self.assertEqual(fit_event.model.filepath, '/path/to/model')
        self.assertEqual(fit_event.model.transformerType, 'modelType')

    def test_fit_metric_events(self):
        metric_events = [event for event in self.events if type(event).__name__ == MetricEvent.__name__]

        self.assertTrue(len(metric_events) == 2)

        for metric_event in metric_events:
            self.assertEqual(metric_event.df.tag, 'test')
            self.assertEqual(metric_event.df.filepath, '/path/to/test')
            self.assertTrue([metadata.key for metadata in metric_event.df.metadata].sort() == ['num_cols', '15'].sort())
            self.assertTrue(
                [metadata.key for metadata in metric_event.df.metadata].sort() == ['dist', 'gaussian'].sort())
            self.assertEqual(metric_event.model.filepath, '/path/to/model')
            self.assertEqual(metric_event.model.transformerType, 'modelType')
            self.assertEqual(metric_event.predictionCol, 'prediction_col')
            if metric_event.metricType is 'confusion_matrix':
                self.assertIsInstance(metric_event.metricValue, list)
            elif metric_event.metricType is 'f1':
                self.assertEqual(metric_event.metricValue, 0.87)
            else:
                raise Exception('Metric Event unexpected')


if __name__ == '__main__':
    unittest.main()
