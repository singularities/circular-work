import Ember from 'ember';

export default Ember.Controller.extend({

  canEditNotifications: Ember.computed('model.organization.isAdmin', function() {
    return this.get('model.organization.isAdmin');
  }),

  actions: {
    cancelEdit (form) {

      // Should use http://emberjs.com/api/data/classes/DS.Model.html#method_resetAttribute
      // but it is not enabled by default
      //
      // And getting attributes from the component, like
      //
      // attributes: [ 'notificationEmail', 'notificationSubject', 'notificationBody' ],
      //
      // var task = this.model;
      //
      // attributes.forEach(function(attr) {
      //  task.resetAttribute(attr);
      // });

      this.model.rollbackAttributes();

      this.set(form, false);
    },
    startEdit(form) {
      this.set(form, true);
    },
    saveEdit(form) {
      this.model.save().then(() => {
        this.set(form, false);
      });
    }
  }
});
