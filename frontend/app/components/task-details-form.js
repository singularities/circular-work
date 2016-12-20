import Ember from 'ember';
import Task from 'frontend/models/task';

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

  Task: Task,

  actions: {
    submitForm() {
      return this.sendAction('formAction', this.task);
    }
  }
});
