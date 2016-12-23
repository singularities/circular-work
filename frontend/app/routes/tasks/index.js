import Ember from 'ember';
//import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin';

//export default Ember.Route.extend(AuthenticatedRouteMixin, {
export default Ember.Route.extend({
  model() {
    return this.get('store').findAll('task');
  }
});
