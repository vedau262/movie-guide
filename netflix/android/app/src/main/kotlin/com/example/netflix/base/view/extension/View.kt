package com.example.netflix.base.view.extension

import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.InputMethodManager
import android.widget.LinearLayout
import android.widget.RelativeLayout

fun View.visible(isShow: Boolean = true) {
    this.visibility = if (isShow) View.VISIBLE else View.GONE
}

fun View.invisible() {
    this.visibility = View.INVISIBLE
}

fun View.gone() {
    this.visibility = View.GONE
}

fun View.enable() {
    this.isEnabled = true
}

fun View.disable() {
    this.isEnabled = false
}

fun View.showKeyBoard(activity: Activity?) {
    activity?.let {
        this.requestFocus()
        val imm = it.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0)
    }
}

fun View.hideKeyboard(activity: Activity?) {
    activity?.let {
        this.clearFocus()
        val imm = it.getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
        imm.hideSoftInputFromWindow(windowToken, 0)
    }
}


fun View.setOnDelayClickListener(method: (View) -> Unit) {
    this.setOnClickListener {
        this.isEnabled = false
        method.invoke(it)
        this.postDelayed({
            this.isEnabled = true
        }, 600)
    }
}

fun View.setColor(color: Int){
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        Log.d("View Extension", "" + this.background);
        if(this.background is GradientDrawable){
            val drawable: GradientDrawable = this.background as GradientDrawable
            drawable.setColor(color)
        } else {
            this.setBackgroundColor(color)
        }
    }
}

fun View.setSize(width: Int? = null, height: Int? = null){
    val param = this.layoutParams as RelativeLayout.LayoutParams
    if (width != null) {
        param.width = width
    }
    if (height != null) {
        param.height = height
    }

    this.layoutParams = param
}

fun View.setMarginOnly(left: Int? = null, right: Int? = null, top: Int? = null, bottom: Int? = null) {
    val param = this.layoutParams as RelativeLayout.LayoutParams

    if (left != null) {
        param.leftMargin = left
    }

    if (right != null) {
        param.rightMargin = right
    }

    if (top != null) {
        param.topMargin = top
    }

    if (bottom != null) {
        param.bottomMargin = bottom
    }

    this.layoutParams = param
}

fun View.setMarginAll(margin: Int? = null) {
    val param = this.layoutParams as RelativeLayout.LayoutParams
    if (margin != null) {
        param.leftMargin = margin
        param.rightMargin = margin
        param.topMargin = margin
        param.bottomMargin = margin
    }

    this.layoutParams = param
}

fun View.setMarginDirection(vertical: Int? = null, horizontal: Int? = null) {
    val param = this.layoutParams as RelativeLayout.LayoutParams
    if (vertical != null) {
        param.topMargin = vertical
        param.bottomMargin = vertical
    }

    if (horizontal != null) {
        param.leftMargin = horizontal
        param.rightMargin = horizontal
    }

    this.layoutParams = param
}

