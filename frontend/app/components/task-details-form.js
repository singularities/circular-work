import Ember from 'ember';

import recurrenceOptions from 'frontend/models/recurrence-options';
import recurrenceMatchPositions from 'frontend/models/recurrence-match-positions';
import recurrenceMatchDays from 'frontend/models/recurrence-match-days';

export default Ember.Component.extend({
  i18n: Ember.inject.service(),
  labels: function() {
    let translations = Ember.Object.create();
    let translator   = this.get('i18n');
    this.get('task').eachAttribute(function(name) {
      let translation = translator.t('tasks.attributes.' + name);
      translations.set(name, translation);
    });
    return translations;
  }.property('taskAttributes'),

  recurrenceOptions:        recurrenceOptions,
  recurrenceMatchPositions: recurrenceMatchPositions,
  recurrenceMatchDays:      recurrenceMatchDays,
  recurrenceMatchPositionId: Ember.computed('task.recurrenceMatch', {
    get: function() {
      return this.getRecurrencePositionId();
    },
    set: function(_key, value) {
      let recurrenceMatch = `${ value } ${ this.getRecurrenceDayId() }`;
      this.set('task.recurrenceMatch', recurrenceMatch);
    }
  }),
  recurrenceMatchDayId: Ember.computed('task.recurrenceMatch', {
    get: function() {
      return this.getRecurrenceDayId();
    },
    set: function(_key, value) {
      let recurrenceMatch = `${ this.getRecurrencePositionId() } ${ value }`;
      this.set('task.recurrenceMatch', recurrenceMatch);
    }
  }),
  getRecurrencePositionId: function() {
    if(this.get('task.recurrenceMatch')) {
      return this.recurrenceOptionAt(0);
    } else {
      return 0;
    }
  },
  getRecurrenceDayId: function() {
    if(this.get('task.recurrenceMatch')) {
      return this.recurrenceOptionAt(1);
    } else {
      return 0;
    }
  },
  recurrenceOptionAt: function(index) {
    let option = this.get('task.recurrenceMatch').split(' ')[index];
    return parseInt(option);
  },
  taskRecurreceIsMonthly: function() {
    return this.get('task.recurrence') === 2;
  }.property('task.recurrence'),
  actions: {
    submitForm() {
      return this.sendAction('formAction', this.task);
    }
  }
});
