import Ember from 'ember';
import recurrenceOptions from 'frontend/models/recurrence-options';
import recurrenceMatchPositions from 'frontend/models/recurrence-match-positions';
import recurrenceMatchDays from 'frontend/models/recurrence-match-days';

export default Ember.Controller.extend({
  actionLabel: function() {
    return this.get('i18n').t('tasks.edit.title');
  }.property(),
  recurrenceOptions:        recurrenceOptions,
  recurrenceMatchPositions: recurrenceMatchPositions,
  recurrenceMatchDays:      recurrenceMatchDays
});
