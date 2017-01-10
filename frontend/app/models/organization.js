import DS from 'ember-data';

const Organization = DS.Model.extend({
  name: DS.attr('string'),

  // Relations
  tasks: DS.hasMany('task'),
  groups: DS.hasMany('groups'),


});

export default Organization;
