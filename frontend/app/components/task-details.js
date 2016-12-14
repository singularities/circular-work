import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-details'],

  showing: Ember.computed.not('editing'),

  actions: {
    edit() {
      this.set('editing', true);
    },
    updateTask() {
      this.task.save().then(() => {
        this.set('editing', false);
      });
    }
  }
});
