import Ember from 'ember';
import DS from 'ember-data';

import recurrenceOptions from 'frontend/models/recurrence-options';
import recurrenceMatchPositionOptions from 'frontend/models/recurrence-match-position-options';
import recurrenceMatchDayOptions from 'frontend/models/recurrence-match-day-options';

const Task =  DS.Model.extend({
  title: DS.attr('string'),
  recurrence: DS.attr('number'),
  recurrenceMatch: DS.attr('string'),
  description: DS.attr('string'),
  notificationEmail: DS.attr('string'),
  notificationSubject: DS.attr('string'),
  notificationBody: DS.attr('string'),

  // Relations
  turns: DS.hasMany('turn'),

  // Computed properties
  recurrenceObject: Ember.computed('recurrence', {
    get() {
      return this.findOption('recurrence');
    },
    set(key, option) {
      this.set('recurrence', option.value);

      return this.findOption('recurrence');
    }
  }),
  recurrenceLabel: Ember.computed('recurrenceObject', function () {
    return this.get('recurrenceObject').label;
  }),

  hasRecurrenceMatch: Ember.computed.notEmpty('recurrenceMatch'),

  recurrenceMatchPosition: Ember.computed('recurrenceMatch', {
    get() {
      return this.recurrenceMatchAt(0);
    },
    set(key, value) {
      let recurrenceMatch = `${ value } ${ this.get('recurrenceMatchDay') }`;

      this.set('recurrenceMatch', recurrenceMatch);

      return value;
    }
  }),
  recurrenceMatchPositionObject: Ember.computed('recurrenceMatchPosition', {
    get() {
      return this.findOption('recurrenceMatchPosition');
    },
    set(key, option) {
      this.set('recurrenceMatchPosition', option.value);

      return this.findOption('recurrenceMatchPosition');
    }
  }),
  recurrenceMatchPositionLabel: Ember.computed('recurrenceMatchPositionObject', function () {
    return this.get('recurrenceMatchPositionObject').label;
  }),
  recurrenceMatchDay: Ember.computed('recurrenceMatch', {
    get() {
      return this.recurrenceMatchAt(1);
    },
    set(key, value) {
      let recurrenceMatch = `${ this.get('recurrenceMatchPosition') } ${ value }`;

      this.set('recurrenceMatch', recurrenceMatch);

      return value;
    }
  }),
  recurrenceMatchDayObject: Ember.computed('recurrenceMatchDay', {
    get() {
      return this.findOption('recurrenceMatchDay');
    },
    set(key, option) {
      this.set('recurrenceMatchDay', option.value);

      return this.findOption('recurrenceMatchDay');
    }
  }),
  recurrenceMatchDayLabel: Ember.computed('recurrenceMatchDayObject', function () {
    return this.get('recurrenceMatchDayObject').label;
  }),

  recurreceIsMonthly: Ember.computed('recurrence', function() {
    return this.get('recurrence') === 2;
  }),

  notificationEmpty: Ember.computed('notificationSubject', 'notificationBody', function () {
    return ! (this.get('notificationSubject') || this.get('notificationBody'));
  }),
  turnsSorting: ['position'],
  sortedTurns: Ember.computed.sort('turns', 'turnsSorting'),
  responsibles: Ember.computed('sortedTurns', function() {
    var turns = this.get('sortedTurns');

    if (turns.length) {
      return turns[0].get('responsibles');
    } else {
      return null;
    }
  }),

  // Helper functions

  /*
   * Finds the option from recurrenceOptions, recurrenceMatchPositionOptions,
   * recurrenceMatchDayOptions that matches value
   *
   * Defaults to current value
   */
  findOption: function(name, value = this.get(name)) {
    return Task.findOption(name, value);
  },
  recurrenceMatchAt: function(index) {
    var value = this.get('recurrenceMatch').split(' ')[index];

    return parseInt(value);
  },
});

Task.reopenClass({
  // Options
  recurrenceOptions:        recurrenceOptions,
  recurrenceMatchPositionOptions: recurrenceMatchPositionOptions,
  recurrenceMatchDayOptions: recurrenceMatchDayOptions,

  findOption: function(name, value) {
    var property = name + 'Options';

    return this[property].find(opt => opt.value === value);
  }
});

export default Task;
