import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['admin-list', 'list-group'],

  showFormModal: false,

  actions: {
    edit () {
      this.set('showFormModal', true);
    }
  }
});
