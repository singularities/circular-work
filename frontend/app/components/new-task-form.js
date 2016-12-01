import Ember from 'ember';

export default Ember.Component.extend({
  labels: function() {
    let translations = Ember.Object.create();
    let translator   = this.get('i18n');
    this.get('task').eachAttribute(function(name) {
      let translation = translator.t('tasks.attributes.' + name);
      translations.set(name, translation);
    });
    return translations;
  }.property('taskAttributes'),
  recurrenceMatchPositionId: Ember.computed('task.recurrenceMatch', {
    get: function() {
      this.getRecurrencePositionId();
    },
    set: function(_key, value) {
      let recurrenceMatch = `${ value } ${ this.getRecurrenceDayId() }`;
      this.set('task.recurrenceMatch', recurrenceMatch);
    }
  }),
  recurrenceMatchDayId: Ember.computed('task.recurrenceMatch', {
    get: function() {
      this.getRecurrenceDayId();
    },
    set: function(_key, value) {
      let recurrenceMatch = `${ this.getRecurrencePositionId() } ${ value }`;
      this.set('task.recurrenceMatch', recurrenceMatch);
    }
  }),
  getRecurrencePositionId: function() {
    if(this.get('task.recurrenceMatch')) {
      return this.get('task.recurrenceMatch').split(' ')[0];
    } else {
      return 0;
    }
  },
  getRecurrenceDayId: function() {
    if(this.get('task.recurrenceMatch')) {
      return this.get('task.recurrenceMatch').split(' ')[1];
    } else {
      return 0;
    }
  },
  taskRecurreceIsMonthly: function() {
    return this.get('task.recurrence') === 2;
  }.property('task.recurrence'),
  actions: {
    createTask() {
      return this.sendAction("createTask", this.task);
    }
  }
});
