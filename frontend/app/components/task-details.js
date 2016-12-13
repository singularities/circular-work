import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-details'],

  showing: Ember.computed.not('editing'),

  actions: {
    cancel() {

      // Should use http://emberjs.com/api/data/classes/DS.Model.html#method_resetAttribute
      // but it is not enabled by default
      //
      // var task = this.task;
      //
      // this.attributes.forEach(function(attr) {
      //  task.resetAttribute(attr);
      // });
      this.task.rollbackAttributes();

      this.set('editing', false);

    },
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
