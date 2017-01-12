import Ember from 'ember';
import DS from 'ember-data';

const Organization = DS.Model.extend({
  name: DS.attr('string'),

  // Relations
  tasks: DS.hasMany('task'),
  groups: DS.hasMany('groups'),

  // Computed properties
  tasksWithTurns: Ember.computed.filterBy('tasks', 'hasTurns')

});

export default Organization;
