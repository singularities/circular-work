import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'span',
  classNames: ['selected-group'],

  // Avoid opening the search dialog on element click
  // https://github.com/cibernox/ember-power-select/issues/381#issuecomment-199794751
  // TODO Implement for touch events
  didInsertElement() {
    this._super(...arguments);

    this.element.addEventListener('mousedown', (e) => {
      e.stopPropagation();
      return false;
    });
  }
});
