import DS from 'ember-data';

const Organization = DS.Model.extend({
  name: DS.attr('string'),

  // Relations
  tasks: DS.hasMany('task'),


});

export default Organization;
