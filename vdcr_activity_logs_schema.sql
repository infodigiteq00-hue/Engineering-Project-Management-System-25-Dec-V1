-- ============================================================================
-- VDCR ACTIVITY LOGS TABLE
-- ============================================================================
-- Description: Table for logging all activities related to VDCR records
-- This table tracks all changes to VDCR records including create, update, 
-- status changes, document uploads, and deletions
-- ============================================================================

-- VDCR Activity Logs Table
CREATE TABLE IF NOT EXISTS public.vdcr_activity_logs (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  project_id uuid NOT NULL,
  vdcr_id uuid,
  activity_type character varying NOT NULL,
  action_description text NOT NULL,
  field_name character varying,
  old_value text,
  new_value text,
  metadata jsonb DEFAULT '{}'::jsonb,
  created_by uuid NOT NULL,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT vdcr_activity_logs_pkey PRIMARY KEY (id),
  CONSTRAINT vdcr_activity_logs_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE,
  CONSTRAINT vdcr_activity_logs_vdcr_id_fkey FOREIGN KEY (vdcr_id) REFERENCES public.vdcr_records(id) ON DELETE CASCADE,
  CONSTRAINT vdcr_activity_logs_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id)
);

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Index for querying logs by project
CREATE INDEX IF NOT EXISTS idx_vdcr_activity_logs_project_id 
  ON public.vdcr_activity_logs(project_id);

-- Index for querying logs by VDCR record
CREATE INDEX IF NOT EXISTS idx_vdcr_activity_logs_vdcr_id 
  ON public.vdcr_activity_logs(vdcr_id);

-- Index for querying logs by activity type
CREATE INDEX IF NOT EXISTS idx_vdcr_activity_logs_activity_type 
  ON public.vdcr_activity_logs(activity_type);

-- Index for querying logs by created_by (user)
CREATE INDEX IF NOT EXISTS idx_vdcr_activity_logs_created_by 
  ON public.vdcr_activity_logs(created_by);

-- Index for querying logs by created_at (for sorting)
CREATE INDEX IF NOT EXISTS idx_vdcr_activity_logs_created_at 
  ON public.vdcr_activity_logs(created_at DESC);




