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
        /* TODO
         * Better handling of errors
         * Currently it is dealing with
         * AdapterError.errors // => ["You need to sign in...."]
         * but also there are:
         * ErrorClass.errors // => [{ detail: 'The adapter ... invalid', title: 'AdapterError'}]
         * but maybe these should be prevented on client
         */
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
