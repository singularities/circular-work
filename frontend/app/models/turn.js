import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  i18n: Ember.inject.service(),

  position: DS.attr('number'),
  task: DS.belongsTo('task'),
  groups: DS.hasMany('group'),

  week: Ember.computed('position', function() {
    return this.get('position') - 1;
  }),

  // This property lets use the zero key in languages that don't have
  // that as pluralization
  weekWithResponsibles: Ember.computed('i18n.locale', 'week', 'responsibles',  function() {
    var key = 'turns.weekWithResponsibles';

    if (this.get('week') === 0) {
      return this.get('i18n').t(key + '.zero', { responsibles: this.get('responsibles')});
    } else {
      return this.get('i18n').t(key, { responsibles: this.get('responsibles'), count: this.get('week')});
    }

  }),

  responsibles: Ember.computed('groups.@each.name', function() {
    return this.get('groups').map(function(e) { return e.get('name'); }).join(', ');
  })
});
