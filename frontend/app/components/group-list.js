import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['group-list', 'list-group'],

  store: Ember.inject.service(),
  i18n: Ember.inject.service(),

  showGroupModal: false,
  canCreateGroup: Ember.computed('organization.isAdmin', function() {
    return this.get('organization.isAdmin');
  }),
  canEditGroup: Ember.computed('organization.isAdmin', function() {
    return this.get('organization.isAdmin');
  }),

  actions: {
    newGroup () {

      this.set('modalGroup', this.get('store').createRecord('group', { organization: this.get('organization')}));

      this.set('modalGroupTitle', this.get('i18n').t('groups.modal.new.title'));

      this.set('showGroupModal', true);
    },
    edit (group) {
      this.set('modalGroup', group);

      this.set('modalGroupTitle', this.get('i18n').t('groups.modal.edit.title'));

      this.set('showGroupModal', true);

    }
  }
});
