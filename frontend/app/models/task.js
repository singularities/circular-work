import DS from 'ember-data';

var fullEmbeddedOptions = {
  async:       false,
  embedded:    'always',
  serialize:   'records',
  deserialize: 'records',
  included:    true
};

export default DS.Model.extend({
  title: DS.attr('string'),
  recurrence: DS.attr('number'),
  recurrenceMatch: DS.attr('string'),
  description: DS.attr('string'),
  email: DS.attr('string'),
  notificationSubject: DS.attr('string'),
  notificationEmail: DS.attr('string'),
  turns: DS.hasMany('turn', fullEmbeddedOptions)
});
