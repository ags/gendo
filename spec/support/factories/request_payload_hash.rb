def create_request_payload_hash
  {
    path:           '/posts/new',
    status:         200,
    started_at:     1370939786.0706801,
    ended_at:       1370939787.0706801,
    db_runtime:     0.1234,
    view_runtime:   0.4567,
    duration:       1.98,
    shinji_version: "0.0.1",
    framework:      "Rails 5.0.0",
    source: {
      controller:   'PostsController',
      action:       'new',
      format_type:  '*/*',
      method_name:  'GET',
    },
    sql_events: [
      {
        sql:          "SELECT * FROM users WHERE id = '1'",
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        duration:     0.321,
      }
    ],
    view_events: [
      {
        identifier:   '/foo/bar.html.erb',
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        duration:     0.321,
      }
    ],
    mailer_events: [
      {
        mailer:     "FooMailer",
        message_id: "4f5b5491f1774_181b23fc3d4434d38138e5@mba.local.mail",
        started_at: 1370939788.0706801,
        ended_at:   1370939789.0706801,
        duration:   0.321,
      }
    ]
  }
end
