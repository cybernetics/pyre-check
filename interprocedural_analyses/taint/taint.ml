(* Copyright (c) 2016-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree. *)

module AccessPath = AccessPath
module BackwardAnalysis = BackwardAnalysis
module CallGraphBuilder = CallGraphBuilder
module TaintConfiguration = Configuration
module PartialSinkConverter = PartialSinkConverter
module Domains = Domains
module Features = Features
module Flow = Flow
module ForwardAnalysis = ForwardAnalysis
module ModelParser = ModelParser

module Model = struct
  include Model
  include ModelParser.T

  let parse = ModelParser.parse

  let verify_model_syntax = ModelParser.verify_model_syntax

  type nonrec taint_annotation = taint_annotation =
    | Sink of {
        sink: Sinks.t;
        breadcrumbs: breadcrumbs;
        path: Abstract.TreeDomain.Label.path;
        leaf_name_provided: bool;
      }
    | Source of {
        source: Sources.t;
        breadcrumbs: breadcrumbs;
        path: Abstract.TreeDomain.Label.path;
        leaf_name_provided: bool;
      }
    | Tito of {
        tito: Sinks.t;
        breadcrumbs: breadcrumbs;
        path: Abstract.TreeDomain.Label.path;
      }
    | AddFeatureToArgument of {
        breadcrumbs: breadcrumbs;
        path: Abstract.TreeDomain.Label.path;
      }
    | SkipAnalysis (* Don't analyze methods with SkipAnalysis *)
    | SkipOverrides (* Analyze as normally, but assume no overrides exist. *)
    | Sanitize

  (* Exposed for testing. *)
  let demangle_class_attribute = ModelVerifier.demangle_class_attribute

  let add_taint_annotation_to_model = ModelParser.add_taint_annotation_to_model
end

module Result = TaintResult
module Sinks = Sinks
module Sources = Sources
