import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  recurrence: DS.attr('number'),
  recurrenceMatch: DS.attr('string'),
  description: DS.attr('string'),
  email: DS.attr('string'),
  notificationEmail: DS.attr('string'),
  notificationSubject: DS.attr('string'),
  notificationBody: DS.attr('string')
});
