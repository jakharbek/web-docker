<?php

$finder = PhpCsFixer\Finder::create()
    ->in(__DIR__ . '/application')
    ->name('*.php')
    ->ignoreDotFiles(true)
    ->ignoreVCS(true);;

return PhpCsFixer\Config::create()
    ->setRules([
        '@PSR2' => true,
        'array_indentation' => true,
        'array_syntax' => ['syntax' => 'short'],
        'binary_operator_spaces' => true,
        'blank_line_after_namespace' => true,
        'blank_line_before_return' => true,
        'braces' => true,
        'class_definition' => true,
        'method_chaining_indentation' => true,
        'no_extra_blank_lines' => true,
        'no_multiline_whitespace_before_semicolons' => true,
        'no_short_echo_tag' => true,
        'no_spaces_around_offset' => true,
        'no_unused_imports' => true,
        'no_whitespace_before_comma_in_array' => true,
        'not_operator_with_successor_space' => true,
        'ordered_imports' => ['sortAlgorithm' => 'length'],
        'trailing_comma_in_multiline_array' => true,
        'trim_array_spaces' => true,
        'single_quote' => true,
        'single_blank_line_before_namespace' => true,
        'return_type_declaration' => true,
        'phpdoc_var_annotation_correct_order' => true,
        'object_operator_without_whitespace' => true,
        'no_whitespace_in_blank_line' => true,
        'no_useless_else' => true,
        'no_useless_return' => true,
        'no_unset_cast' => true,
        'no_trailing_comma_in_singleline_array' => true,
        'no_trailing_comma_in_list_call' => true,
        'no_empty_statement' => true,
        'no_empty_phpdoc' => true,
        'no_empty_comment' => true,
        'no_blank_lines_after_class_opening' => true,
        'new_with_braces' => true,
        'magic_constant_casing' => true,
        'lowercase_cast' => true,
        'linebreak_after_opening_tag' => true,
        'include' => true,
        'combine_consecutive_unsets' => true,
        'combine_consecutive_issets' => true,
        'align_multiline_comment' => true,
        'yoda_style' => null])
    ->setFinder($finder);