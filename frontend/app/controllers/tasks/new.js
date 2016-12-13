import Ember from 'ember';

export default Ember.Controller.extend({
  i18n: Ember.inject.service(),
  actionLabel:              function() {
    return this.get('i18n').t('tasks.new.title');
  }.property()
});
