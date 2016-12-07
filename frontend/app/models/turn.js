import DS from 'ember-data';

export default DS.Model.extend({
  task: DS.belongsTo('task'),
  position: DS.attr('number'),
  groups: DS.hasMany('group')
});
