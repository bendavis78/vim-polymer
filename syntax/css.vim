syn keyword polymerElement cascaded-animation
syn keyword polymerElement date-input
syn keyword polymerElement date-validator
syn keyword polymerElement fade-in-animation
syn keyword polymerElement fade-out-animation
syn keyword polymerElement gold-cc-cvc-input
syn keyword polymerElement gold-cc-expiration-input
syn keyword polymerElement gold-cc-input
syn keyword polymerElement gold-email-input
syn keyword polymerElement gold-phone-input
syn keyword polymerElement gold-zip-input
syn keyword polymerElement hero-animation
syn keyword polymerElement iron-a11y-announcer
syn keyword polymerElement iron-a11y-keys
syn keyword polymerElement iron-ajax
syn keyword polymerElement iron-autogrow-textarea
syn keyword polymerElement iron-collapse
syn keyword polymerElement iron-component-page
syn keyword polymerElement iron-doc-property
syn keyword polymerElement iron-doc-viewer
syn keyword polymerElement iron-form
syn keyword polymerElement iron-icon
syn keyword polymerElement iron-iconset
syn keyword polymerElement iron-iconset-svg
syn keyword polymerElement iron-image
syn keyword polymerElement iron-input
syn keyword polymerElement iron-jsonp-library
syn keyword polymerElement iron-list
syn keyword polymerElement iron-localstorage
syn keyword polymerElement iron-media-query
syn keyword polymerElement iron-meta
syn keyword polymerElement iron-meta-query
syn keyword polymerElement iron-overlay-backdrop
syn keyword polymerElement iron-pages
syn keyword polymerElement iron-request
syn keyword polymerElement iron-selector
syn keyword polymerElement iron-signals
syn keyword polymerElement neon-animatable
syn keyword polymerElement neon-animated-pages
syn keyword polymerElement opaque-animation
syn keyword polymerElement paper-button
syn keyword polymerElement paper-card
syn keyword polymerElement paper-checkbox
syn keyword polymerElement paper-dialog
syn keyword polymerElement paper-dialog-scrollable
syn keyword polymerElement paper-drawer-panel
syn keyword polymerElement paper-fab
syn keyword polymerElement paper-header-panel
syn keyword polymerElement paper-icon-button
syn keyword polymerElement paper-icon-item
syn keyword polymerElement paper-input
syn keyword polymerElement paper-input-char-counter
syn keyword polymerElement paper-input-container
syn keyword polymerElement paper-input-error
syn keyword polymerElement paper-item
syn keyword polymerElement paper-item-body
syn keyword polymerElement paper-material
syn keyword polymerElement paper-menu
syn keyword polymerElement paper-progress
syn keyword polymerElement paper-radio-button
syn keyword polymerElement paper-radio-group
syn keyword polymerElement paper-ripple
syn keyword polymerElement paper-scroll-header-panel
syn keyword polymerElement paper-slider
syn keyword polymerElement paper-spinner
syn keyword polymerElement paper-tabs
syn keyword polymerElement paper-tab
syn keyword polymerElement paper-textarea
syn keyword polymerElement paper-toast
syn keyword polymerElement paper-toggle-button
syn keyword polymerElement paper-toolbar
syn keyword polymerElement paper-tooltip
syn keyword polymerElement platinum-push-messaging
syn keyword polymerElement platinum-sw-cache
syn keyword polymerElement platinum-sw-fetch
syn keyword polymerElement platinum-sw-import-script
syn keyword polymerElement platinum-sw-register
syn keyword polymerElement reverse-ripple-animation
syn keyword polymerElement ripple-animation
syn keyword polymerElement scale-down-animation
syn keyword polymerElement scale-up-animation
syn keyword polymerElement slide-down-animation
syn keyword polymerElement slide-from-left-animation
syn keyword polymerElement slide-from-right-animation
syn keyword polymerElement slide-left-animation
syn keyword polymerElement slide-right-animation
syn keyword polymerElement slide-up-animation
syn keyword polymerElement transform-animation
syn keyword polymerElement zip-validator

" ShadowDOM selectors
syn match shadowDomSelector "\s\+\(/deep/\|:host\|::shadow\|::content\)\s\+"

" Custom Elements
syn match customElement "\(^\|\s\)\zs\([a-z]\+-\)\+[a-z]\+\ze"

" CSS3 Custom properties
syn match cssCustomProp contained "\(^\|;\|\s\)\@<=--[a-zA-Z_][a-zA-Z0-9_-]*\>\(\s*:\s*{\)\@!"
syn match cssVendorProp contained "\(^\|;\|\s\)\@<=-[a-zA-Z_][a-zA-Z0-9_-]*\>"

" Polymer CSS mixins
syn match cssMixinName contained "\(^\|;\|\s\)\@<=--[a-zA-Z_][a-zA-Z0-9_-]*\>\(\s*:\s*{\)\@="
syn region cssMixinDefinition contained transparent matchgroup=cssBraces start="\(^\|;\|\s\)--[a-zA-Z_][a-zA-Z0-9_-]*\>:\s*\zs{" end="}" contains=cssDefinition,cssAttrRegion,cssMixinName,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise,cssMixinDefinition,cssMixinName,cssApplyRegion,cssApplyName fold
syn region cssApplyRegion contained matchgroup=cssApplyName start="\(^\|\s\)@apply\s*(" end=")" oneline keepend
 
 
" Redefine cssAttrRegion to exclude mixin regions
syn clear cssDefinition
syn region cssDefinition transparent matchgroup=cssBraces start='{' end='}' contains=cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise,cssMixinDefinition,cssMixinName,cssApplyRegion,cssApplyName fold

syn clear cssAttrRegion
syn region cssAttrRegion contained start=/:\(\s*{\)\@!/ end=/\ze\(;\|)\|}\)/ contained contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise


hi link polymerElement cssTagName
hi link customElement cssTagName
hi link cssMixinName cssClassName
hi link cssCustomProp cssProp
hi link cssVendorProp cssProp
hi link cssApplyName cssFunctionName
hi link cssApplyRegion cssFunction
hi link shadowDomSelector Special
