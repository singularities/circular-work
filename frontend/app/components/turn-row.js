import Ember from 'ember';

export default Ember.Component.extend({
  store: Ember.inject.service(),
  tagName: 'li',
  showNewGroupModal: false,

  newGroupParams: function() {
    return {
      name:   this.get('newGroupName'),
      emails: this.get('newGroupEmails')
    };
  },
  cleanNewGroupParams: function() {
    this.set('newGroupName', '');
    this.set('newGroupEmails', '');
  },
  actions: {
    addGroup: function() {
      this.set('showNewGroupModal', true);
    },
    createGroup: function() {
      let group = this.get('store')
        .createRecord('group', this.newGroupParams());
      this.get('turn.groups').pushObject(group);
      this.cleanNewGroupParams();
      this.set('showNewGroupModal', false);
    }
  }
});
