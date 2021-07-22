package com.example.netflix



import android.R
import android.content.Context
import android.view.View
import android.widget.ArrayAdapter
import android.widget.ListView
import com.example.netflix.base.view.MyScrollView
import io.flutter.plugin.platform.PlatformView

internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {

    private  val scrollView = MyScrollView(context)
    val recipeList = mutableListOf({ "hello"; "hi"})
//    private val listView: ListView
//        get() {
////            listView.setAda
//        }

    val listItems = arrayOfNulls<String>(recipeList.size)
    val adapter = ArrayAdapter<String>(context, R.layout.simple_list_item_1, listItems)
//    private val inflater: LayoutInflater = context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
    val listView  = ListView(context)

    val myCustomLayout = MyCustomLayout(context);

    override fun getView(): View {
        return scrollView
    }

    override fun dispose() {}

    init {
        scrollView.addView(myCustomLayout)
    }
}
