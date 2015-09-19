syn match polymerElement "\(cascaded-animation\|date-input\|date-validator\|fade-in-animation\|fade-out-animation\|gold-cc-cvc-input\|gold-cc-expiration-input\|gold-cc-input\|gold-email-input\|gold-phone-input\|gold-zip-input\|hero-animation\|iron-a11y-announcer\|iron-a11y-keys\|iron-ajax\|iron-autogrow-textarea\|iron-collapse\|iron-component-page\|iron-doc-property\|iron-doc-viewer\|iron-form\|iron-icon\|iron-iconset\|iron-iconset-svg\|iron-image\|iron-input\|iron-jsonp-library\|iron-list\|iron-localstorage\|iron-media-query\|iron-meta\|iron-meta-query\|iron-overlay-backdrop\|iron-pages\|iron-request\|iron-selector\|iron-signals\|neon-animatable\|neon-animated-pages\|opaque-animation\|paper-button\|paper-card\|paper-checkbox\|paper-dialog\|paper-dialog-scrollable\|paper-drawer-panel\|paper-fab\|paper-header-panel\|paper-icon-button\|paper-icon-item\|paper-input\|paper-input-char-counter\|paper-input-container\|paper-input-error\|paper-item\|paper-item-body\|paper-material\|paper-menu\|paper-progress\|paper-radio-button\|paper-radio-group\|paper-ripple\|paper-scroll-header-panel\|paper-slider\|paper-spinner\|paper-tab\|paper-tabs\|paper-textarea\|paper-toast\|paper-toggle-button\|paper-toolbar\|paper-tooltip\|platinum-push-messaging\|platinum-sw-cache\|platinum-sw-fetch\|platinum-sw-import-script\|platinum-sw-register\|reverse-ripple-animation\|ripple-animation\|scale-down-animation\|scale-up-animation\|slide-down-animation\|slide-from-left-animation\|slide-from-right-animation\|slide-left-animation\|slide-right-animation\|slide-up-animation\|transform-animation\|zip-validator\)"

" ShadowDOM selectors
syn match shadowDomSelector "\s\+\(/deep/\|:host\|::shadow\|::content\)\s\+"

" Custom Elements
syn match customElement "([a-z]-)+[a-z]+"

" CSS3 Custom properties
syn match cssCustomProp contained "\(^\|;\|\s\)\@<=--[a-zA-Z_][a-zA-Z0-9_-]*\>\(\s*:\s*{\)\@!"
syn match cssVendorProp contained "\(^\|;\|\s\)\@<=-[a-zA-Z_][a-zA-Z0-9_-]*\>"

" Polymer CSS mixins
syn match cssMixinName contained "\(^\|;\|\s\)\@<=--[a-zA-Z_][a-zA-Z0-9_-]*\>\(\s*:\s*{\)\@="
syn region cssMixinDefinition contained transparent matchgroup=cssBraces start="\(^\|;\|\s\)--[a-zA-Z_][a-zA-Z0-9_-]*\>:\s*{" end="}" contains=cssDefinition,cssAttrRegion,cssMixinName,cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise,cssMixinDefinition,cssMixinName,cssApplyRegion,cssApplyName fold
syn region cssApplyRegion matchgroup=cssApplyName start="@apply\s*(" end=")" oneline keepend
 
 
" Redefine cssAttrRegion to exclude mixin regions
syn clear cssDefinition
syn region cssDefinition transparent matchgroup=cssBraces start='{' end='}' contains=cssAttrRegion,css.*Prop,cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape,cssVendor,cssDefinition,cssHacks,cssNoise,cssMixinDefinition,cssMixinName,cssApplyRegion,cssApplyName fold

syn clear cssAttrRegion
syn region cssAttrRegion contained start=/:\(\s*{\)\@!/ end=/\ze\(;\|)\|}\)/ contained contains=css.*Attr,cssColor,cssImportant,cssValue.*,cssFunction,cssString.*,cssURL,cssComment,cssUnicodeEscape,cssVendor,cssError,cssAttrComma,cssNoise


hi link polymerElement cssTagName
hi link customElement cssSelectorOp
hi link shadowDomSelector cssSelectorOp
hi link cssMixinName cssProp
hi link cssCustomProp cssProp
hi link cssVendorProp cssProp
hi link cssApplyName cssFunctionName
hi link cssApplyRegion cssFunction
