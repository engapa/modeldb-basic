import unittest

from ...basic.ModelDbSyncerBase import *
from .ModelDbSyncerBaseTest import SyncerTest
from . import utils


class TestJson(unittest.TestCase):

    @classmethod
    def setUp(self):

        syncer_obj = SyncerTest.create_syncer_from_config()

        model_filename = os.path.abspath(
            os.path.join(os.path.dirname(__file__), os.pardir, 'unit/files/JsonSample.json'))

        syncer_obj.sync_all(model_filename)

        self.events = syncer_obj.sync()

    def test_events_and_types(self):
        # There should be 6 events, 3 from project info, 1 fit event and 2 metric event
        self.assertEqual(len(self.events), 6)

        utils.validate_project_struct(self.events[0].project, self)
        utils.validate_experiment_struct(self.events[1].experiment, self)
        utils.validate_experiment_run_struct(self.events[2].experimentRun, self)
        utils.validate_fit_event_struct(self.events[3], self)
        utils.validate_metric_event_struct(self.events[4], self)
        utils.validate_metric_event_struct(self.events[5], self)


class TestYaml(unittest.TestCase):

    @classmethod
    def setUp(self):

        syncer_obj = SyncerTest.create_syncer_from_config()

        model_filename = os.path.abspath(
            os.path.join(os.path.dirname(__file__), os.pardir, 'unit/files/YamlSample.yaml'))

        syncer_obj.sync_all(model_filename)

        self.events = syncer_obj.sync()

    def test_events_and_types(self):
        # There should be 5 events, 3 from project info, 1 fit event and 2 metric event
        self.assertEqual(len(self.events), 5)

        utils.validate_project_struct(self.events[0].project, self)
        utils.validate_experiment_struct(self.events[1].experiment, self)
        utils.validate_experiment_run_struct(self.events[2].experimentRun, self)
        utils.validate_fit_event_struct(self.events[3], self)
        utils.validate_metric_event_struct(self.events[4], self)


if __name__ == '__main__':
    unittest.main()
