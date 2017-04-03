import Ember from 'ember';

export default Ember.Controller.extend({

  store: Ember.inject.service(),

  organization: {},

  actions: {

    create () {
      var controller = this;

      this.get('store').createRecord('organization', this.get('organization')).save().then((organization) => {

        controller.transitionToRoute('organizations.show', organization);
      });
    },
    cancel () {
      this.set('organization', {});

      this.transitionToRoute('index');
    }
  }
});
