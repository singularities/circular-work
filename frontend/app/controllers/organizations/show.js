import Ember from 'ember';

export default Ember.Controller.extend({

  canCreateTask: Ember.computed('model.isAdmin', function() {
    return this.get('model.isAdmin');
  }),
});
