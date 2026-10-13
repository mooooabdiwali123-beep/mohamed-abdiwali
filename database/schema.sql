-- Nabad Medical Center: illustrative PostgreSQL schema only.
-- Do not use with real patient data until authentication, authorization,
-- encryption, audit logging, backups, retention, and legal/privacy review are implemented.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE staff (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  role TEXT NOT NULL,
  department TEXT,
  phone TEXT,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE patients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_number TEXT NOT NULL UNIQUE,
  full_name TEXT NOT NULL,
  phone TEXT,
  date_of_birth DATE,
  sex TEXT CHECK (sex IN ('male','female','other','unknown')),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE appointments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id),
  staff_id UUID REFERENCES staff(id),
  department TEXT NOT NULL,
  starts_at TIMESTAMPTZ NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','confirmed','completed','cancelled','no_show')),
  booking_note TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX appointments_starts_at_idx ON appointments(starts_at);
CREATE INDEX appointments_patient_id_idx ON appointments(patient_id);

CREATE TABLE lab_results (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  patient_id UUID NOT NULL REFERENCES patients(id),
  ordered_by UUID REFERENCES staff(id),
  test_name TEXT NOT NULL,
  result_summary TEXT,
  status TEXT NOT NULL DEFAULT 'pending'
    CHECK (status IN ('pending','processing','ready','reviewed','cancelled')),
  collected_at TIMESTAMPTZ,
  resulted_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX lab_results_patient_id_idx ON lab_results(patient_id);

-- Recommended for a real system: create user accounts separately, restrict
-- each role's access, record every read/change in an append-only audit log,
-- require HTTPS, use server-side validation, encrypt backups, and never expose
-- this database directly to a public browser.
