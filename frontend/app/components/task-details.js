import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-details'],

  showing: Ember.computed.not('editing'),

  canEditTask: Ember.computed('task.organization.isAdmin', function() {
    return this.get('task.organization.isAdmin');
  }),
});
