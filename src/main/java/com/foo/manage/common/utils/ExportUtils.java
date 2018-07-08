package com.foo.manage.common.utils;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

/**
 * 导出工具类
 * @author changzhongq
 * @time 2018年7月7日 上午11:21:24
 */
public class ExportUtils {
	/**
	 * 获取Execl并填充值
	 * @param sheetName sheet名称
	 * @param title 标题
	 * @param values 内容
	 * @param wb HSSFWorkbook对象
	 * @return
	 */
	public static HSSFWorkbook getHSSFWorkbook(String sheetName, List<String> titleLabels, List<String> titleNames, List<?> rows, HSSFWorkbook wb) {

		// 第一步，创建一个HSSFWorkbook，对应一个Excel文件
		if (wb == null) {
			wb = new HSSFWorkbook();
		}

		// 第二步，在workbook中添加一个sheet,对应Excel文件中的sheet
		Sheet sheet = wb.createSheet(sheetName);

		// 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制
		Row row = sheet.createRow(0);

		// 第四步，创建单元格，并设置值表头 设置表头居中
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

		// 声明列对象
		Cell cell = null;

		// 创建标题
		for (int i = 0; i < titleLabels.size(); i++) {
			cell = row.createCell(i);
			cell.setCellValue(titleLabels.get(i));
			cell.setCellStyle(style);
		}

		// 创建内容
		for (int i = 0; i < rows.size(); i++) {
			row = sheet.createRow(i + 1);
			Map<String, Object> rowMap = CommonUtils.objToMapUpper(rows.get(i));
			for (int j = 0; j < titleNames.size(); j++) {
				String title = titleNames.get(j);
				row.createCell(j).setCellValue(rowMap.get(title) + "");
			}
		}
		return wb;
	}

}
