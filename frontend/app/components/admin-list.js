import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['admin-list', 'list-group'],

  showFormModal: false,

  canEditAdmins: Ember.computed('organization.isAdmin', function() {
    return this.get('organization.isAdmin');
  }),

  actions: {
    edit () {
      this.set('showFormModal', true);
    }
  }
});
