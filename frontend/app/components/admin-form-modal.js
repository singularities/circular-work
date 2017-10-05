import Ember from 'ember';

export default Ember.Component.extend({

  openConfirmRemove: false,

  actions: {
    cancel () {
      this.get('organization').rollbackAttributes();
    },

    save () {
      let organization  = this.get('organization');

      organization.save().then(() => {

        this.set('organizationErrors', null);
        this.set('requestErrors', null);

        this.set('open', false);
      }).catch((error) => {
        this.set('organizationErrors', organization.get('errors'));
        this.set('requestErrors', error.errors);
      });
    },
  }
});
