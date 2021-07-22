package com.example.netflix.base.view

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.GradientDrawable
import android.util.Log
import android.util.TypedValue
import android.view.Gravity
import android.view.ViewGroup
import android.widget.EditText
import android.widget.RelativeLayout
import android.widget.TextView
import com.example.netflix.R
import com.example.netflix.base.view.extension.convertDpToPx
import com.example.netflix.base.view.extension.convertSpToPx

class MyTextView(context: Context, id: Int, text: String) : TextView(context){
//    private val verticalMargin = resources.getDimensionPixelSize(R.dimen.dp_20)
    private val size = resources.getDimensionPixelSize(R.dimen.sp_20).toFloat()
    private val size1 = resources.getDimension(R.dimen.sp_20).toFloat()


    init {
//        Log.d("MyTextView", "sp_20 $size")
//        Log.d("MyTextView", "size1 $size1")
//        Log.d("MyTextView", "convertSpToPx ${20.convertSpToPx()}")
//        Log.d("MyTextView", "convertDpToPx ${20.convertDpToPx()}")

        val param = RelativeLayout.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT, ViewGroup.LayoutParams.WRAP_CONTENT)
//        param.topMargin =verticalMargin
//        param.bottomMargin =verticalMargin
        this.layoutParams = param
        this.id = id
        this.setTextSize(TypedValue.COMPLEX_UNIT_PX, resources.getDimension(R.dimen.sp_20))
        this.text = text
        this.gravity = Gravity.CENTER_HORIZONTAL
    }
}