import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  recurrence: DS.attr('number'),
  recurrenceMatch: DS.attr('string'),
  description: DS.attr('string'),
  notificationEmail: DS.attr('string'),
  notificationSubject: DS.attr('string'),
  notificationBody: DS.attr('string'),
  notificationEmpty: Ember.computed('notificationSubject', 'notificationBody', function () {
    return ! (this.get('notificationSubject').length || this.get('notificationBody').length);
  }),
  turns: DS.hasMany('turn'),
  turnsSorting: ['position'],
  sortedTurns: Ember.computed.sort('turns', 'turnsSorting')
});
