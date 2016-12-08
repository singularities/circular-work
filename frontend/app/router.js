import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend().extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('session', function() {
    this.route('login');
    this.route('register');
    this.route('password_forgotten');
  });

  this.route('tasks', function() {
    this.route('index');
    this.route('new');
    this.route('show', { path: ":task_id" });
  });
});

export default Router;
