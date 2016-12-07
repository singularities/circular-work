import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'select',
  change: function(event) {
    var index  = event.target.selectedIndex;
    var choice = this.get('iterableChoices').objectAt(index);

    this.set('value', choice.value);
  },
  iterableChoices: function() {
    if(this.get('choices.length') === 0) {
      return {};
    }
    return this.get('choices').map(function(choice) {
      if(choice.constructor.name === 'String') {
        var selected = this.get('value') === choice ? 'selected="selected"' : '';
        return { label: choice, value: choice, selected: selected };
      } else {
        let isSelected = this.get('value') === choice.value ? 'selected' : '';
        choice.set('selected', isSelected);
        return choice;
      }
    }, this);
  }.property('choices,value')
});
