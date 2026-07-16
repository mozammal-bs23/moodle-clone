# Moodle Student App — Feature & API Specification

**Source:** derived from the official Moodle Mobile App codebase (Ionic/Angular + Capacitor), by grepping actual service files for the Moodle Web Service (WS) function names each screen calls — not from memory of Moodle's docs. Every endpoint below was confirmed against `src/**/services/*.ts`.

## 0. Scope rule

The Moodle app has no role-based code split — every screen is shown or hidden based on the logged-in user's **capabilities** on the site, not a hardcoded "Student" flag. So "the Student part" is a scoping decision, applied here as:

| | |
|---|---|
| **Include** | Consume content, submit/attempt your own work, view your own grades & feedback, participate (post, reply, rate, comment), manage your own profile/files/notifications/calendar. |
| **Exclude** | Grade or evaluate others, view aggregate/participant/analytics data, moderate other users' content, edit or administer courses/site. |

Modules where that line is genuinely blurry (assign, workshop, feedback, forum, data) are called out explicitly below rather than silently split.

## 1. Transport layer (applies to every feature)

All features below ride on the same four HTTP endpoints — this is the actual wire protocol, not per-feature:

| Endpoint | Purpose |
|---|---|
| `POST /login/token.php` | Exchange username/password (or SSO passport) for a WS token |
| `GET /admin/tool/mobile/launch.php` | Browser-based SSO login callback |
| `POST /webservice/rest/server.php?moodlewsrestformat=json` | Single JSON-RPC-style endpoint — every WS function call below is a POST here with `wsfunction=<name>` |
| `POST /webservice/upload.php` | Multipart file upload (submissions, private files, avatar, attachments) |
| `GET /webservice/pluginfile.php/...` / `/tokenpluginfile.php/...` | Authenticated file download for content embedded in courses |

**Implication for estimation:** there is effectively one API client, and "the API list" below is a catalogue of `wsfunction` values sent to that one endpoint — not 150 separate REST routes.

---

## 2. Feature list

### Tier 0 — Foundation (cross-cutting, needed before any feature works)

- Multi-site login: manual site URL, site search, SSO via system browser, QR-code login, "log in as guest"
- Session security: PIN/biometric app lock, auto-logout after inactivity, change/forgot password
- **Offline mode & background sync** — cache course content for offline reading; queue assignment submissions, forum posts, quiz attempts, choice/data/glossary entries made offline; auto-sync on reconnect + manual "sync now"; per-item sync error surfacing. *(This is not a minor add-on — a large share of the app's real complexity lives here: every write-capable module ships an offline queue and a conflict/retry path.)*
- Push notification registration (device token) + local notifications for reminders
- File handling: download manager, storage usage view, camera/gallery/file picker for uploads
- App settings: language, text size, sync-over-Wi-Fi-only, storage manager, about/version
- Global search (courses, users, content)
- Site policy acceptance & GDPR data-privacy requests (view/export/cancel own data)
- Age/digital-consent verification flow (site-dependent, for signup)

### Tier 1 — Core student journey

| Feature | Description |
|---|---|
| Dashboard ("My overview") | Timeline of upcoming/overdue activities, course cards, filters, starred/recent courses, badges & calendar widgets |
| My Courses | List, category browse, search, self-enrolment (with/without key), guest access |
| Course content | Section/topic navigation, activity list, download for offline |
| Completion tracking | View own progress; manually self-mark activity/course complete where enabled |
| Grades | "Overview" report (all courses) and "User" report (single-course grade breakdown + teacher feedback) |
| Calendar | Month/day/upcoming views, personal events, activity due-date events, local reminders |
| Notifications | In-app + push feed, mark read |
| Messaging | Contacts, 1:1 & group conversations, message requests, block/mute/favourite |
| Notes | View notes a teacher has left visible to the student |
| Profile | View/edit own profile, change picture, preferences |
| Private files | Browse/download own Moodle private files; upload from device |
| Badges | View earned badges & criteria |
| Blogs | View site/course blog entries, write own entries |
| Tags | Browse content by tag |
| Learning plans / Competencies | View own plan(s) and competency progress (read-only for student) |

### Tier 2 — Activity modules (what a student *does* inside a course)

| Module | Student can do | Explicitly excluded (teacher-only) |
|---|---|---|
| **Assignment** | View brief, submit file/online text, edit before due date, view own status/grade/feedback, resubmit | Grading UI, submissions list, participant list |
| **Quiz** | View access rules (password/time limit/attempts), start/resume attempt, answer questions, submit, review own attempt & grade (if the quiz allows review) | — (fully student-scoped by nature) |
| **Forum** | Browse/read discussions, post, reply, edit/delete own post, subscribe, star discussion, attach files, search | Lock/pin discussion, delete others' posts, moderation |
| **Choice** | View options, submit/change response, view results (only if the activity is configured to show them) | — |
| **Workshop** | Submit own work, assess allocated peer submissions via the rubric, view own grade breakdown | Evaluate assessments, grades report, reviewer-assignment tools (teacher) |
| **Feedback** | Answer the (paged) form, view own previous response | Response analysis, non-respondent list |
| **Glossary** | Browse (alpha/date/category/author), search, view entry, add entry (if allowed), comment/rate | — |
| **Wiki** | View pages + page history, edit/create pages (if permitted), per-group/per-user subwikis | — |
| **Lesson** | Navigate content/question pages, branching, review own attempt | Attempts-overview across all students |
| **SCORM** | Download & play package online/offline, track score, resume | — |
| **H5P activity** | Play interactive content, own attempt results | Results across all users |
| **Database** | Browse/search entries, add/edit own entries | Approve others' entries |
| **Survey** (built-in instrument) | Answer once | — |
| **Chat** | Join live session, send/receive messages, view past transcripts | — |
| **BigBlueButton** | View meeting info, join live session, view recordings | End meeting, meeting management |
| **LTI / external tool** | Launch tool with SSO | — |
| **Resource / URL / Page / Book / Folder / Label / IMS package** | Pure content consumption — view/download/navigate | — |
| **Subsection** | Navigate nested sections | — |

*Question types (~17: multiple choice, true/false, matching, numerical, essay, drag-drop, etc.) and question behaviours (~10: deferred feedback, adaptive, etc.) aren't standalone features — they're the rendering/interaction engine Quiz and Lesson depend on. Treat as a Quiz-module complexity multiplier, not a separate line item.*

### Tier 3 — Dashboard/course widgets relevant to a student

Starred courses · Recently accessed courses/items · Timeline · Calendar (month/upcoming) · Badges · Private files · Comments · Learning plans · Self-completion · Course list · Glossary random entry · Tags · Global search · Site news (announcements) · Blog menu/recent/tags · HTML (static) block

*Excluded as teacher/course-management oriented: Online users (roster), Recent activity (course-wide log), Activity results (aggregate stats display).*

### Tier 4 — Out of scope for a Student build

- Assignment / Workshop / Quiz grading interfaces, participant & submissions lists
- Forum moderation (lock, pin, cross-user delete)
- Feedback/Survey response analytics, non-respondent lists
- Report Builder (custom reports) and Analytics/Insights (at-risk predictions)
- Course/category creation & editing, site/user/cohort administration
- Competency **rating** (a teacher rating a student — viewing is in scope, rating is not)
- Database entry approval workflow

---

## 3. API list (Moodle Web Service functions, by feature)

All calls below are `wsfunction` values POSTed to `/webservice/rest/server.php`. **[R]** = read/fetch, **[W]** = write/action.

### Auth & site
- `[R]` `core_webservice_get_site_info` — fetch site + user info after login (called on every login)
- `[R]` `tool_mobile_get_public_config`, `tool_mobile_get_config` — site config before/after auth
- `[R]` `tool_mobile_get_autologin_key` — SSO handoff
- `[R]` `core_auth_is_age_digital_consent_verification_enabled`, `core_auth_is_minor`
- `[W]` `core_auth_request_password_reset`, `core_auth_resend_confirmation_email`
- `[R]` `auth_email_get_signup_settings` / `[W]` `auth_email_signup_user`
- `[R]` `tool_mobile_call_external_functions` — batches several of the calls below into one HTTP round-trip (perf optimization, not a separate feature)
- `[W]` `core_user_add_user_device` / `core_user_remove_user_device` — push notification device registration
- `[W]` `core_user_agree_site_policy` · `[R]` `tool_policy_get_user_acceptances` / `[W]` `tool_policy_set_acceptances_status`
- `[R]` `tool_dataprivacy_get_access_information` / `[W]` `tool_dataprivacy_create_data_request`, `tool_dataprivacy_cancel_data_request`, `tool_dataprivacy_contact_dpo`

### Courses & dashboard
- `[R]` `core_enrol_get_users_courses`, `core_course_get_enrolled_courses_by_timeline_classification`, `core_course_get_recent_courses`
- `[R]` `core_course_search_courses`, `core_course_get_courses_by_field`, `core_course_get_categories`
- `[R]` `core_course_get_contents`, `core_course_get_course_module`, `core_course_check_updates` (drives offline sync)
- `[R]` `core_courseformat_get_overview_information`
- `[W]` `core_course_view_course`, `core_course_view_module_instance_list` — analytics "viewed" logging
- `[W]` `core_course_set_favourite_courses` — star a course
- `[R]` `core_block_get_dashboard_blocks`, `core_block_get_course_blocks`
- `[R]` `core_completion_get_activities_completion_status` / `[W]` `core_completion_update_activity_completion_status_manually`
- `[R]` `core_completion_get_course_completion_status` / `[W]` `core_completion_mark_course_self_completed`
- `[R]` `enrol_self_get_instance_info`, `enrol_guest_get_instance_info` / `[W]` `enrol_self_enrol_user`, `enrol_guest_validate_password`
- `[R]` `core_course_get_user_navigation_options`, `core_course_get_user_administration_options`

### Grades
- `[R]` `gradereport_overview_get_course_grades`, `gradereport_overview_view_grade_report` *(logging)*
- `[R]` `gradereport_user_get_grades_table`, `gradereport_user_get_grade_items`, `gradereport_user_get_access_information`, `gradereport_user_view_grade_report`

### Calendar
- `[R]` `core_calendar_get_calendar_monthly_view`, `core_calendar_get_calendar_day_view`, `core_calendar_get_calendar_upcoming_view`, `core_calendar_get_calendar_events`, `core_calendar_get_calendar_event_by_id`
- `[R]` `core_calendar_get_action_events_by_course/-courses/-timesort` — dashboard "timeline" data
- `[W]` `core_calendar_submit_create_update_form` / `core_calendar_delete_calendar_events` — personal events only

### Notifications & messaging
- `[R]` `core_message_get_messages`, `core_message_get_unread_notification_count` / `[W]` `core_message_mark_notification_read`, `core_message_mark_all_notifications_as_read`, `core_message_get_user_notification_preferences`
- `[R]` `core_message_get_conversations`, `core_message_get_conversation`, `core_message_get_conversation_messages`, `core_message_get_conversation_members`, `core_message_get_user_contacts`, `core_message_search_users`
- `[W]` `core_message_send_messages_to_conversation`, `core_message_send_instant_messages`, `core_message_create_contact_request`, `core_message_confirm/decline_contact_request`, `core_message_block_user`/`unblock_user`, `core_message_delete_message`, `core_message_set_favourite_conversations`, `core_message_mute_conversations`

### Profile, files, notes, badges, blogs, tags
- `[R]` `core_user_get_course_user_profiles`, `core_user_get_users_by_field`, `core_user_get_user_preferences` / `[W]` `core_user_update_user_preferences`, `core_user_update_picture`
- `[R]` `core_files_get_files`, `core_user_get_private_files_info` / `[W]` `core_user_add_user_private_files`, `core_user_update_private_files`
- `[R]` `core_notes_get_course_notes`
- `[R]` `core_badges_get_user_badges`, `core_badges_get_badge`, `core_badges_get_user_badge_by_hash`
- `[R]` `core_blog_get_entries` / `[W]` `core_blog_add_entry`, `core_blog_update_entry`, `core_blog_delete_entry`
- `[R]` `core_tag_get_tag_cloud`, `core_tag_get_tagindex_per_area`

### Learning plans / competencies (read-only for student)
- `[R]` `tool_lp_data_for_plans_page`, `tool_lp_data_for_plan_page`, `tool_lp_data_for_course_competencies_page`, `tool_lp_data_for_user_competency_summary(_in_course|_in_plan)`

### Supporting/infra (used across many modules)
- `[R]` `core_group_get_course_user_groups`, `core_group_get_activity_allowed_groups`, `core_group_get_activity_groupmode` — group-mode-aware activities
- `[R]` `core_rating_get_item_ratings` / `[W]` `core_rating_add_rating` — used by Glossary/Forum rating
- `[R]` `core_comment_get_comments` / `[W]` `core_comment_add_comments`, `core_comment_delete_comments`
- `[R]` `core_search_get_results`, `core_search_get_search_areas_list`
- `[R]` `core_filters_get_available_in_context` — content filter (e.g. MathJax) rendering

### Assignment (`mod_assign`)
- `[R]` `mod_assign_get_assignments`, `mod_assign_get_submission_status`
- `[W]` `mod_assign_save_submission`, `mod_assign_start_submission`, `mod_assign_submit_for_grading`, `mod_assign_remove_submission`
- `[W]` `mod_assign_view_assign`, `mod_assign_view_submission_status` *(logging)*
- *Excluded:* `mod_assign_get_submissions`, `mod_assign_list_participants`, `mod_assign_submit_grading_form`, `mod_assign_view_grading_table`, `mod_assign_get_grades` (teacher/grading side)

### Quiz (`mod_quiz`)
- `[R]` `mod_quiz_get_quizzes_by_courses`, `mod_quiz_get_quiz_access_information`, `mod_quiz_get_quiz_required_qtypes`, `mod_quiz_get_combined_review_options`
- `[R]` `mod_quiz_get_attempt_data`, `mod_quiz_get_attempt_access_information`, `mod_quiz_get_attempt_summary`, `mod_quiz_get_attempt_review`, `mod_quiz_get_user_attempts`, `mod_quiz_get_user_best_grade`, `mod_quiz_get_quiz_feedback_for_grade`
- `[W]` `mod_quiz_start_attempt`, `mod_quiz_save_attempt`, `mod_quiz_process_attempt`
- `[W]` `mod_quiz_view_quiz`, `mod_quiz_view_attempt`, `mod_quiz_view_attempt_review`, `mod_quiz_view_attempt_summary` *(logging)*

### Forum (`mod_forum`)
- `[R]` `mod_forum_get_forums_by_courses`, `mod_forum_get_forum_access_information`, `mod_forum_get_forum_discussions`, `mod_forum_get_forum_discussions_paginated`, `mod_forum_get_forum_discussion_posts`, `mod_forum_get_discussion_post(s)`, `mod_forum_can_add_discussion`
- `[W]` `mod_forum_add_discussion`, `mod_forum_add_discussion_post`, `mod_forum_update_discussion_post`, `mod_forum_delete_post` *(own post)*, `mod_forum_toggle_favourite_state`, `mod_forum_prepare_draft_area_for_post`
- *Excluded:* `mod_forum_set_lock_state`, `mod_forum_set_pin_state` (moderation)

### Workshop (`mod_workshop`)
- `[R]` `mod_workshop_get_workshops_by_courses`, `mod_workshop_get_workshop_access_information`, `mod_workshop_get_user_plan`, `mod_workshop_get_submission`, `mod_workshop_get_submissions` *(own)*, `mod_workshop_get_assessment`, `mod_workshop_get_assessment_form_definition`, `mod_workshop_get_grades`
- `[W]` `mod_workshop_add_submission`, `mod_workshop_update_submission`, `mod_workshop_delete_submission`, `mod_workshop_update_assessment`
- *Excluded:* `mod_workshop_evaluate_submission`, `mod_workshop_evaluate_assessment`, `mod_workshop_get_grades_report`, `mod_workshop_get_reviewer_assessments`, `mod_workshop_get_submission_assessments` (teacher-side moderation of peer assessment)

### Choice / Feedback / Survey / Data / Glossary / Wiki / Lesson / SCORM / H5P / Chat (student-relevant only)
- **Choice:** `[R]` `mod_choice_get_choices_by_courses`, `mod_choice_get_choice_options`, `mod_choice_get_choice_results` · `[W]` `mod_choice_submit_choice_response`, `mod_choice_delete_choice_responses`
- **Feedback:** `[R]` `mod_feedback_get_feedbacks_by_courses`, `mod_feedback_get_feedback_access_information`, `mod_feedback_get_items`, `mod_feedback_get_page_items`, `mod_feedback_get_current_completed_tmp`, `mod_feedback_get_last_completed` · `[W]` `mod_feedback_launch_feedback`, `mod_feedback_process_page` — *excluded:* `get_analysis`, `get_responses_analysis`, `get_non_respondents`, `get_finished/unfinished_responses`
- **Survey:** `[R]` `mod_survey_get_surveys_by_courses`, `mod_survey_get_questions` · `[W]` `mod_survey_submit_answers`
- **Database:** `[R]` `mod_data_get_databases_by_courses`, `mod_data_get_data_access_information`, `mod_data_get_fields`, `mod_data_get_entries`, `mod_data_get_entry`, `mod_data_search_entries` · `[W]` `mod_data_add_entry`, `mod_data_update_entry`, `mod_data_delete_entry` *(own)* — *excluded:* `mod_data_approve_entry`
- **Glossary:** `[R]` `mod_glossary_get_glossaries_by_courses`, `mod_glossary_get_entries_by_author/-category/-date/-letter/-search`, `mod_glossary_get_entry_by_id`, `mod_glossary_get_categories` · `[W]` `mod_glossary_add_entry`, `mod_glossary_update_entry`, `mod_glossary_delete_entry`
- **Wiki:** `[R]` `mod_wiki_get_wikis_by_courses`, `mod_wiki_get_subwikis`, `mod_wiki_get_subwiki_pages`, `mod_wiki_get_page_contents`, `mod_wiki_get_page_for_editing`, `mod_wiki_get_subwiki_files` · `[W]` `mod_wiki_new_page`, `mod_wiki_edit_page`
- **Lesson:** `[R]` `mod_lesson_get_lessons_by_courses`, `mod_lesson_get_lesson_access_information`, `mod_lesson_get_lesson`, `mod_lesson_get_pages`, `mod_lesson_get_page_data`, `mod_lesson_get_pages_possible_jumps`, `mod_lesson_get_user_attempt`, `mod_lesson_get_user_timers`, `mod_lesson_get_questions_attempts`, `mod_lesson_get_content_pages_viewed` · `[W]` `mod_lesson_launch_attempt`, `mod_lesson_process_page`, `mod_lesson_finish_attempt`
- **SCORM:** `[R]` `mod_scorm_get_scorms_by_courses`, `mod_scorm_get_scorm_access_information`, `mod_scorm_get_scorm_scoes`, `mod_scorm_get_scorm_user_data`, `mod_scorm_get_scorm_attempt_count` · `[W]` `mod_scorm_launch_sco`, `mod_scorm_insert_scorm_tracks`
- **H5P activity:** `[R]` `mod_h5pactivity_get_h5pactivities_by_courses`, `mod_h5pactivity_get_h5pactivity_access_information`, `mod_h5pactivity_get_attempts`, `mod_h5pactivity_get_user_attempts`, `mod_h5pactivity_get_results` · `[W]` `core_xapi_post_state`, `core_xapi_get_state` — *excluded:* `mod_h5pactivity_get_results` across other users
- **Chat:** `[R]` `mod_chat_get_chats_by_courses`, `mod_chat_get_sessions`, `mod_chat_get_session_messages`, `mod_chat_get_chat_users` · `[W]` `mod_chat_login_user`, `mod_chat_send_chat_message`

### Pure content-consumption modules (no write actions)
`mod_resource_get_resources_by_courses`, `mod_url_get_urls_by_courses`, `mod_page_get_pages_by_courses`, `mod_book_get_books_by_courses`, `mod_folder_get_folders_by_courses`, `mod_label_get_labels_by_courses`, `mod_imscp_get_imscps_by_courses`, `mod_lti_get_ltis_by_courses` + `mod_lti_get_tool_launch_data` (SSO launch), `mod_bigbluebuttonbn_get_bigbluebuttonbns_by_courses` + `mod_bigbluebuttonbn_get_join_url`, `mod_bigbluebuttonbn_get_recordings` — each paired with a `mod_<name>_view_<name>` logging call.

---

## 4. Notes for estimation

- **Offline sync is a first-class requirement, not a stretch goal.** `core_course_check_updates` plus an offline write-queue exists for nearly every write-capable module above (assign, quiz, forum, choice, data, glossary, wiki, workshop). Budget for it per-module, not once.
- **File upload is a separate REST call**, not a WS function — `POST /webservice/upload.php` — used by assignment submissions, private files, avatar, and any module with file attachments (forum, glossary, wiki, workshop).
- **`tool_mobile_call_external_functions` lets you batch reads** — e.g. the dashboard fires one HTTP request that bundles `core_enrol_get_users_courses` + `core_block_get_dashboard_blocks` + several others. Worth adopting early; retrofitting batching later is more work.
- Numbers cited elsewhere as `core_grades_get_grades` are **not real** — the actual grade endpoints are the `gradereport_overview_*` / `gradereport_user_*` family. This list was verified against source, not recalled from Moodle docs, specifically to avoid that kind of error.
