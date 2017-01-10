import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  i18n: Ember.inject.service(),

  position: DS.attr('number'),
  task: DS.belongsTo('task'),
  groups: DS.hasMany('group'),

  organization: Ember.computed('task.organization', function() {
    return this.get('task.organization');
  }),

  week: Ember.computed('position', function() {
    return this.get('position') - 1;
  }),

  // This property lets use the zero key in languages that don't have
  // that as pluralization
  weekInWords: Ember.computed('i18n.locale', 'week', function() {
    var key = 'turns.week';

    if (this.get('week') === 0) {
      return this.get('i18n').t(key + '.zero');
    } else {
      return this.get('i18n').t(key, { count: this.get('week')});
    }

  }),

  responsibles: Ember.computed('groups.@each.name', function() {
    return this.get('groups').map(function(e) { return e.get('name'); }).join(', ');
  })
});
