import Ember from 'ember';
import OrganizationTokenEntry from '../../mixins/organization-token-entry';

export default Ember.Route.extend(OrganizationTokenEntry, {
  model(params) {
    return this.get('store').findRecord('task', params.task_id, {include: 'turns'});
  }
});
