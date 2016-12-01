import Ember from 'ember';
import recurrenceOptions from 'frontend/models/recurrence-options';
import recurrenceMatchPositions from 'frontend/models/recurrence-match-positions';
import recurrenceMatchDays from 'frontend/models/recurrence-match-days';

export default Ember.Controller.extend({
  i18n: Ember.inject.service(),
  actionLabel:              function() {
    return this.get('i18n').t('tasks.new.title');
  }.property(),
  recurrenceOptions:        recurrenceOptions,
  recurrenceMatchPositions: recurrenceMatchPositions,
  recurrenceMatchDays:      recurrenceMatchDays
});
