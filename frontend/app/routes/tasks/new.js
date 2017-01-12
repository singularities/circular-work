import Ember from 'ember';
import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

export default Ember.Route.extend(AuthenticatedRouteMixin, {
  queryParams: {
    organization_id: {
      refreshModel: true
    }
  },

  model(params) {
    return this.get('store').findRecord('organization', params.organization_id).then((organization) => {
      return this.get('store').createRecord('task', { organization: organization });
    });
  },

  actions: {
    createTask(task) {
      var route = this;
      task.save().then(function() {
        route.transitionTo('tasks.show', task);
      }).catch(function() { });
    }
  }
});
