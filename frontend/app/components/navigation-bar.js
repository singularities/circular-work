import Ember from 'ember';

export default Ember.Component.extend({
  session: Ember.inject.service(),
  
  loggedAs: function() {
    return this.get('session.data.authenticated.email');
  }.property('session.data'),
  actions: {
     invalidateSession() {
       this.get('session').invalidate();
     }
   }
});
