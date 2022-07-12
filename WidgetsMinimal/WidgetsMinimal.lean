import Lean
open Lean Elab

elab (name := includeStr) "include_str " str:str : term => do
  let some str := str.isStrLit? | Lean.Elab.throwUnsupportedSyntax
  let ctx ← readThe Lean.Core.Context
  let srcPath := System.FilePath.mk ctx.fileName
  let some srcDir := srcPath.parent | throwError "{srcPath} not in a valid directory"
  let path := srcDir / str
  Lean.mkStrLit <$> IO.FS.readFile path

@[widgetSource]
def minimalWidget : String := include_str "./widget/dist/index.js"

/-- This should be the same as `Props` in `index.tsx`-/
structure Props where
  name : String
  count? : Option Nat
  deriving ToJson, FromJson, Inhabited

def eg : Props := {name := "Jeremy", count? := some 100000}

#widget minimalWidget (toJson eg)