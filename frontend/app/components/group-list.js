import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['group-list', 'list-group'],

  i18n: Ember.inject.service(),

  showGroupModal: false,

  actions: {
    edit (group) {
      this.set('modalGroup', group);

      this.set('modalGroupTitle', this.get('i18n').t('groups.modal.edit.title'));

      this.set('showGroupModal', true);

    }
  }
});
