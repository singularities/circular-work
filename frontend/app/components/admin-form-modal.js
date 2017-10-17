import Ember from 'ember';

export default Ember.Component.extend({

  openConfirmRemove: false,

  actions: {
    cancel () {
      this.cleanErrors();
      
      this.get('organization').rollbackAttributes();
    },

    save () {
      let organization  = this.get('organization');

      organization.save().then(() => {

        this.cleanErrors();

        this.set('open', false);
      }).catch((error) => {
        this.set('organizationErrors', organization.get('errors'));
        this.set('requestErrors', error.errors);
      });
    },
  },

  cleanErrors () {
    this.set('organizationErrors', null);
    this.set('requestErrors', null);
  }
});
