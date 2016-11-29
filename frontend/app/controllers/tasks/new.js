import Ember from 'ember';
import recurrenceOptions from 'frontend/models/recurrence-options';
import recurrenceMatchPositions from 'frontend/models/recurrence-match-positions';
import recurrenceMatchDays from 'frontend/models/recurrence-match-days';

export default Ember.Controller.extend({
  recurrenceOptions: recurrenceOptions,
  recurrenceMatchPositions: recurrenceMatchPositions,
  recurrenceMatchDays: recurrenceMatchDays
});
