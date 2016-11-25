import Ember from 'ember';

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
  taskRecurreceIsWeekly: function() {
    return this.get('task.recurrence') === 1;
  }.property('task.recurrence'),
  actions: {
    createTask() {
      return this.sendAction("createTask", this.task);
    }
  }
});
