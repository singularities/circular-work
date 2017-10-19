import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['task-list', 'list-group'],

  canCreateTask: Ember.computed('organization.isAdmin', function () {
    return this.get('organization.isAdmin');
  }),

  tasksWatchingNextOcurrenceAt: Ember.computed('tasks.@each.nextOcurrenceAt', function () {
    return this.get('tasks');
  }),

  sortedTasks: Ember.computed.sort('tasksWatchingNextOcurrenceAt', (a, b) => {
    let aMoment = a.get('nextOcurrenceAt'),
        bMoment = b.get('nextOcurrenceAt');

    if (! (aMoment && bMoment)) {
      return 0;
    }

    if (aMoment.isBefore(bMoment)) {
      return -1;
    } else if (aMoment.isAfter(bMoment)) {
      return 1;
    } else {
      return 0;
    }
  })
});
