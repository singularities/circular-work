import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  turns: DS.hasMany('turn')
});
